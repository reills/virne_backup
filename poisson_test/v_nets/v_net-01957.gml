graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 1957
  arrival_time 42861.58754806806
  lifetime 1048.0256488361433
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 42
    rom 17
  ]
  node [
    id 1
    label "1"
    cpu 19
    gpu 42
    rom 14
  ]
  node [
    id 2
    label "2"
    cpu 21
    gpu 41
    rom 31
  ]
  node [
    id 3
    label "3"
    cpu 30
    gpu 33
    rom 19
  ]
  node [
    id 4
    label "4"
    cpu 7
    gpu 35
    rom 40
  ]
  node [
    id 5
    label "5"
    cpu 6
    gpu 0
    rom 7
  ]
  node [
    id 6
    label "6"
    cpu 48
    gpu 8
    rom 42
  ]
  node [
    id 7
    label "7"
    cpu 35
    gpu 50
    rom 12
  ]
  node [
    id 8
    label "8"
    cpu 9
    gpu 26
    rom 28
  ]
  node [
    id 9
    label "9"
    cpu 49
    gpu 48
    rom 40
  ]
  node [
    id 10
    label "10"
    cpu 28
    gpu 46
    rom 25
  ]
  edge [
    source 0
    target 1
    bw 38
  ]
  edge [
    source 1
    target 2
    bw 25
  ]
  edge [
    source 2
    target 3
    bw 27
  ]
  edge [
    source 3
    target 4
    bw 10
  ]
  edge [
    source 4
    target 5
    bw 8
  ]
  edge [
    source 5
    target 6
    bw 17
  ]
  edge [
    source 6
    target 7
    bw 0
  ]
  edge [
    source 7
    target 8
    bw 35
  ]
  edge [
    source 8
    target 9
    bw 19
  ]
  edge [
    source 9
    target 10
    bw 27
  ]
]
