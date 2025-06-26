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
  id 1066
  arrival_time 22413.393755545047
  lifetime 3637.289491325912
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 9
    rom 17
  ]
  node [
    id 1
    label "1"
    cpu 49
    gpu 1
    rom 16
  ]
  node [
    id 2
    label "2"
    cpu 23
    gpu 37
    rom 49
  ]
  node [
    id 3
    label "3"
    cpu 12
    gpu 43
    rom 19
  ]
  node [
    id 4
    label "4"
    cpu 6
    gpu 35
    rom 10
  ]
  node [
    id 5
    label "5"
    cpu 14
    gpu 26
    rom 44
  ]
  node [
    id 6
    label "6"
    cpu 9
    gpu 35
    rom 28
  ]
  node [
    id 7
    label "7"
    cpu 3
    gpu 39
    rom 5
  ]
  node [
    id 8
    label "8"
    cpu 27
    gpu 41
    rom 25
  ]
  node [
    id 9
    label "9"
    cpu 35
    gpu 34
    rom 38
  ]
  node [
    id 10
    label "10"
    cpu 7
    gpu 7
    rom 45
  ]
  node [
    id 11
    label "11"
    cpu 43
    gpu 2
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 47
  ]
  edge [
    source 1
    target 2
    bw 10
  ]
  edge [
    source 2
    target 3
    bw 8
  ]
  edge [
    source 3
    target 4
    bw 39
  ]
  edge [
    source 4
    target 5
    bw 28
  ]
  edge [
    source 5
    target 6
    bw 46
  ]
  edge [
    source 6
    target 7
    bw 46
  ]
  edge [
    source 7
    target 8
    bw 48
  ]
  edge [
    source 8
    target 9
    bw 9
  ]
  edge [
    source 9
    target 10
    bw 48
  ]
  edge [
    source 10
    target 11
    bw 49
  ]
]
