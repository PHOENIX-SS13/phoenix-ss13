import { useBackend, useLocalState } from '../backend';
import { Button } from '../components';
import { Window } from '../layouts';


export const OvermapOpsConsole = (props, context) => {
  const { act, data } = useBackend(context);

  return (
    <Window width={300} height={180} title="Shuttle Console">
      <Window.Content scrollable align="center">
        <br />
        <Button
          ml={1}
          icon="map"
          color="blue"
          content="Overmap View"
          onClick={() => act('overmap_view')} />
        <br /><br />
        <Button
          ml={1}
          icon="gamepad"
          content="Shuttle Controls"
          color="white"
          onClick={() => act('overmap_ship_controls')} />
      </Window.Content>
    </Window>
  );
};
