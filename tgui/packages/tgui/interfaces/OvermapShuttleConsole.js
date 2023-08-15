import { useBackend, useLocalState } from '../backend';
import { Tabs, Box, Button, Dropdown, Flex, Icon, LabeledList, Modal, Section } from '../components';
import { Window } from '../layouts';


export const OvermapShuttleConsole = (props, context) => {
  const { act, data } = useBackend(context);

  const {
    status,
  } = data;

  return (
    <Window width={400} height={450} title="Shuttle Controls">
      <Window.Content scrollable>
        <Button
          ml={1}
          icon="plane-up"
          content="Depart To Overmap"
          onClick={() => act('overmap_launch')} /><br />
        <Button
          ml={1}
          icon="battery-full"
          content="Engines On"
          onClick={() => act('engines_on')} />
        <Button
          ml={1}
          icon="battery-empty"
          content="Engines Off"
          onClick={() => act('engines_off')} />
        <Button
          ml={1}
          icon="map-location"
          content="Overmap View"
          onClick={() => act('overmap_view')} />
        <Button
          ml={1}
          icon="gamepad"
          content="Shuttle Controls"
          onClick={() => act('overmap_ship_controls')} />
      </Window.Content>
    </Window>
  );
};
